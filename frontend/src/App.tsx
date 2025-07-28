import { useState, useEffect } from 'react'
import './App.css'
import { healthService, type HealthResponse } from './services/healthService'

function App() {
  const [health, setHealth] = useState<HealthResponse | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    const checkHealth = async () => {
      const healthData = await healthService.checkHealth()
      setHealth(healthData)
      setLoading(false)
    }
    
    checkHealth()
  }, [])

  return (
    <>
      <div>
        <div>
          <h2>Backend Health Status</h2>
          {loading ? (
            <p>Checking health...</p>
          ) : health ? (
            <div>
              <p>Status: <strong style={{color: health.message === 'OK' ? 'green' : 'red'}}>{health.message}</strong></p>
            </div>
          ) : (
            <p>Unable to check health</p>
          )}
        </div>
      </div>
    </>
  )
}

export default App
